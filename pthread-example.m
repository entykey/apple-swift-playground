#import <Foundation/Foundation.h>
#include <pthread.h>
#import <mach/mach_time.h>

// Function to be executed by the thread
void *threadFunction(void *arg) {
    printf("Thread started\n");
    
    // Perform some work...
    
    printf("Thread finished\n");
    
    return NULL;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Record the start time
        uint64_t startTime = mach_absolute_time();

        // Create a thread
        pthread_t thread;
        if (pthread_create(&thread, NULL, threadFunction, NULL) != 0) {
            // NSLog(@"Failed to create thread");
            printf("Failed to create thread\n");
            return 1;
        }
        
        // Wait for the thread to finish
        if (pthread_join(thread, NULL) != 0) {
            // NSLog(@"Failed to join thread");
            printf("Failed to create thread\n");
            return 1;
        }

        // Record the end time
        uint64_t endTime = mach_absolute_time();
        
        // Calculate the elapsed time in nanoseconds
        uint64_t elapsedNanoseconds = endTime - startTime;
        
        // Convert nanoseconds to microseconds, milliseconds, and seconds
        double elapsedMicroseconds = (double)elapsedNanoseconds / NSEC_PER_USEC;
        double elapsedMilliseconds = (double)elapsedNanoseconds / NSEC_PER_MSEC;
        double elapsedSeconds = (double)elapsedNanoseconds / NSEC_PER_SEC;
        
        // Print the execution time in microseconds, milliseconds, and seconds
        printf("Execution time: %.6f µs\n", elapsedMicroseconds);
        printf("Execution time: %.6f ms\n", elapsedMilliseconds);
        printf("Execution time: %.6f s\n", elapsedSeconds);
    }
    return 0;
}

/* To build & run:
$ clang -framework Foundation pthread-example.m -o pthread-example
$ ./pthread-example
*/