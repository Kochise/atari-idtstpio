# idtstpio
Atari program to identify IDE attached devices

* Hardware and software needed

You need the following to get this program working :

\- Atari with IDE port mapped like the one in a Falcon030<br>

* List of programs

\- IDTSTPIO.PRG : device identitifer based on ATA-ATAPI 5 specification<br>
\- \\SAVE : some previous hacks for archival purpose<br>
\- \\TEST : some more tests with third parties source code to consider<br>

* How to use it

Just run the 'IDTSTPIO.PRG', it will try to identify the attached devices on the IDE port and print the result. A 'REPORT.LOG' will be generated and also contains the identified devices.

* Known limitations

This use direct access to the IDE port, bypassing any installed driver. Since this is just sensing identifiers, it shouldn't conflict with any software, especially considering the TOS is not multi-task. If nothing is found reading at the IDE port, the program exit.

* Some infos

This was a test to improve drive detection of my own driver. The SCSI code was not ported since it worked well already (packet) but the DMA routines needed a rework that never happened.
