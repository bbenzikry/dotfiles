#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <signal.h>

int ioin[2];
int ioout[2];
int ioerr[2];

void handler(int sig)
{
    printf("Closing everything!\n");

    close(ioin[0]);
    close(ioin[1]);
    close(ioout[0]);
    close(ioout[1]);
    close(ioerr[0]);
    close(ioerr[1]);
}

int main(int argc, const char * argv[]) {
    pipe(ioin);
    pipe(ioout);
    pipe(ioerr);

    // execvp(argv[1], argv+1);

    signal(SIGHUP, &handler);

    if(fork() == 0)
    {
        close(ioin[0]); // close in read
        close(ioout[1]); // close in write
        close(ioerr[1]); // close in write

        if(fork() == 0)
        {
            if(fork() == 0)
            {
                char buf;
                FILE* f = fopen("stdin.log", "w+");
                // fprintf(f, "%d\n", getpid());
                // fflush(f);
                while (read(STDIN_FILENO, &buf, 1) > 0) {
                    write(ioin[1], &buf, 1);
                    fwrite(&buf, 1, 1, f);
                    fflush(f);
                }
                fprintf(f, "Done\n");

                fclose(f);
                close(ioin[1]);
                close(0);

                kill(0, SIGHUP);

                _exit(0);
            }
            else
            {
                char buf;
                FILE* f = fopen("stdout.log", "w+");
                // fprintf(f, "%d\n", getpid());
                // fflush(f);
                while (read(ioout[0], &buf, 1) > 0) {
                    write(STDOUT_FILENO, &buf, 1);
                    fwrite(&buf, 1, 1, f);
                    fflush(f);
                }
                fprintf(f, "Done\n");

                fclose(f);
                close(ioout[0]);
                _exit(0);
            }
        }
        else
        {
            char buf;
            FILE* f = fopen("stderr.log", "w+");
            // fprintf(f, "%d\n", getpid());
            // fflush(f);
            while (read(ioerr[0], &buf, 1) > 0) {
                write(STDERR_FILENO, &buf, 1);
                fwrite(&buf, 1, 1, f);
                fflush(f);
            }
            fprintf(f, "Done\n");


            fclose(f);
            close(ioerr[0]);
            _exit(0);
        }
    }
    else
    {
        close(ioin[1]); // close in write
        close(ioout[0]); // close in read
        close(ioerr[0]); // close in read

        if(fork() == 0)
        {
            close(0);
            dup(ioin[0]);

            close(1);
            dup(ioout[1]);

            close(2);
            dup(ioerr[1]);

            execvp(argv[1], argv+1);
        }
        else
        {
            wait(NULL);
        }
    }
}
