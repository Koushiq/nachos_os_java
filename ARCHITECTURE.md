# Nachos OS Project Architecture

The Nachos (Not Another Completely Heuristic Operating System) project is a pedagogical operating system designed to teach students about operating system concepts. It is implemented in Java and simulates various hardware components and OS functionalities. The project is structured into several main packages, each addressing a different aspect of an operating system.

## 1. Machine Simulation (`nachos.machine`)

This package provides the core hardware simulation components of the Nachos OS. These components mimic the behavior of real hardware, allowing the OS kernel to interact with a simulated environment.

*   **`Machine.java`**: The entry point for the Nachos simulation. It initializes all hardware devices, processes command-line arguments, loads configuration from `nachos.conf`, and starts the autograder.
*   **`Processor.java`**: Simulates a MIPS processor, including registers, physical memory, and address translation (page table or TLB). It handles instruction execution and various CPU exceptions.
*   **`Interrupt.java`**: Emulates the hardware interrupt controller, managing pending interrupts and advancing simulated time.
*   **`Timer.java`**: Simulates a hardware timer that generates periodic CPU interrupts, essential for time-slicing and thread sleep mechanisms.
*   **`SerialConsole.java` / `StandardConsole.java`**: Defines an interface for a serial console and a concrete implementation that uses `System.in` and `System.out` for character I/O.
*   **`FileSystem.java` / `StubFileSystem.java`**: Defines a file system interface and a stub implementation that redirects file operations to the host OS's file system.
*   **`OpenFile.java` / `OpenFileWithPosition.java` / `ArrayFile.java`**: Base classes and an in-memory implementation for file operations, including reading, writing, seeking, and managing file pointers.
*   **`Coff.java` / `CoffSection.java`**: Implement a COFF (Common Object File Format) loader for executable files, parsing sections and loading them into memory.
*   **`NetworkLink.java` / `Packet.java` / `MalformedPacketException.java`**: Components for simulating a network link, handling packet creation, transmission, reception, and error detection.
*   **`ElevatorBank.java` / `ElevatorControllerInterface.java` / `ElevatorControls.java` / `ElevatorEvent.java` / `ElevatorGui.java` / `RiderInterface.java` / `RiderControls.java` / `RiderEvent.java` / `ElevatorTest.java`**: A set of classes for simulating an elevator system, including a bank of elevators, controllers, riders, events, and a GUI.
*   **`Stats.java`**: Collects and reports runtime statistics of the Nachos machine.
*   **`Lib.java`**: A utility class providing common helper functions like assertions, random number generation, debugging, and byte manipulation.
*   **`TCB.java`**: Simulates a Thread Control Block, responsible for low-level thread management (creation, context switching, destruction) by wrapping JVM `Thread` objects.
*   **`TranslationEntry.java`**: Represents a single entry in a page table or TLB, mapping virtual to physical page numbers and containing status flags.

## 2. Threading (`nachos.threads`)

This package implements the core threading primitives and scheduling algorithms for the Nachos OS.

*   **`KThread.java`**: Represents a kernel thread, managing its lifecycle (fork, join, yield, sleep, finish) and interacting with the scheduler and TCBs.
*   **`Scheduler.java`**: An abstract base class for thread schedulers, defining the interface for managing `ThreadQueue`s.
*   **`ThreadQueue.java`**: An abstract base class for queues that hold threads waiting for access to a resource.
*   **`RoundRobinScheduler.java`**: A concrete `Scheduler` implementation that uses a FIFO queue for scheduling, providing round-robin access.
*   **`PriorityScheduler.java`**: A `Scheduler` implementation that prioritizes threads, supporting priority donation to mitigate priority inversion.
*   **`LotteryScheduler.java`**: (Incomplete/Stub) A `Scheduler` intended to implement lottery scheduling, where threads receive tickets and access is granted randomly based on ticket count.
*   **`Lock.java`**: A basic synchronization primitive for mutual exclusion.
*   **`Semaphore.java`**: A synchronization primitive for controlling access to a common resource with a counting mechanism.
*   **`Condition.java` / `Condition2.java`**: Implementations of Mesa-style condition variables for inter-thread communication, allowing threads to wait for specific conditions to be met.
*   **`Alarm.java`**: Utilizes the hardware timer to implement thread preemption and timed waits (`waitUntil`).
*   **`SynchList.java`**: A synchronized list implementation using a `Lock` and `Condition` for safe concurrent access.
*   **`Communicator.java`**: Provides a mechanism for threads to synchronously exchange 32-bit messages.
*   **`ThreadedKernel.java`**: Extends `Kernel` to provide multi-threading capabilities, initializing the scheduler, alarm, and performing self-tests for threading components.
*   **`Boat.java`**: Contains a self-test for the "Boat" synchronization problem, used for grading.
*   **`Rider.java` / `ElevatorController.java`**: (Incomplete/Stub) Classes related to the elevator simulation within the threads package, likely placeholders for student implementation.

## 3. User Programs (`nachos.userprog`)

This package focuses on supporting the execution of user programs within the Nachos OS, including process management, virtual memory, and system calls.

*   **`UserKernel.java`**: Extends `ThreadedKernel` to enable multiple user processes. It manages physical memory, initializes a synchronized console, and sets the processor's exception handler for user program exceptions.
*   **`UserProcess.java`**: Encapsulates the state of a single user process. It handles loading COFF executables, managing the process's page table (virtual memory), and implements various system calls (halt, exit, exec, join, create, open, read, write, close, unlink).
*   **`UThread.java`**: Extends `KThread` to represent a user thread, specifically designed to execute user program code within a `UserProcess`. It manages user-level CPU registers.
*   **`SynchConsole.java`**: Provides a synchronized interface to the console, allowing user processes to perform character I/O safely.

## 4. Virtual Memory (`nachos.vm`)

This package extends the user program functionality to include demand-paged virtual memory.

*   **`VMKernel.java`**: Extends `UserKernel` to incorporate virtual memory management, typically involving page fault handling and swapping. (Currently a minimal extension of `UserKernel`).
*   **`VMProcess.java`**: Extends `UserProcess` to support demand-paging, managing virtual-to-physical address translation in more detail. (Currently a minimal extension of `UserProcess`).

## 5. Networking (`nachos.network`)

This package builds upon the virtual memory and user program features to add network communication capabilities.

*   **`NetKernel.java`**: Extends `VMKernel` to provide network support, primarily through the `PostOffice`.
*   **`NetProcess.java`**: Extends `VMProcess` to enable user processes to make network-related system calls.
*   **`MailMessage.java`**: Represents a mail message, used for higher-level network communication on top of the raw packet layer.
*   **`PostOffice.java`**: Provides a message passing service for inter-machine communication, managing local ports and message queues.

## 6. Autograder and Security (`nachos.ag`, `nachos.security`)

These packages provide tools for grading and enforcing security within the Nachos environment.

*   **`ag/AutoGrader.java`**: The primary autograder class, responsible for loading and testing the Nachos kernel and its components.
*   **`ag/BoatGrader.java`**: A specific autograder component for the "Boat" synchronization problem.
*   **`security/NachosSecurityManager.java`**: A custom `SecurityManager` for Java that restricts certain operations to prevent malicious Nachos code from affecting the host system.
*   **`security/Privilege.java`**: An abstract class used to grant privileged access to specific Nachos machine operations, ensuring that only authorized kernel components can perform sensitive tasks.

## 7. Project-Specific Files

*   **`proj1/test.java`**: Contains test cases relevant to Project 1, specifically for `JoinTest` and `Condition2Test` functionalities, indicating this is where early project-specific testing takes place.

This architecture demonstrates a layered approach, starting from low-level hardware simulation up to user program execution and networking, with clear separation of concerns among the different packages.




