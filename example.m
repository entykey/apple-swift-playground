#import <Foundation/Foundation.h>
#import <mach/mach_time.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Record the start time
        uint64_t startTime = mach_absolute_time();
        
        // Your Objective-C code
        // NSLog(@"Hello, Objective-C!");   // sucks due to overhead
        printf("Hello, Objective-C!\n");
        
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
$ clang -framework Foundation example.m -o example
$ ./example
*/