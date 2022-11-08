### Bash script tooling to have a fast development environment setup at any Debian-based Linux distribution

There are two goals here:
 
 - Be able to run a single script to download ZSH, install the plugins I like, set up aliases, and have my customized environment available anywhere in any Debian-based Linux.
 - Install a package that made it able to change between projects without the need to think which local dependencies are needed or which commands are set to run the project as dev.

The second goal shall be usuless when working on a single project at a time, for Node.Js development once it already has tooling for that and any other language that has similar tooling.

However, it may be a little painful to change the environment when we code for multiple projects using multiple languages, each one with its own tooling This script shall only handle that change detecting which tooling should be used and running whatever is need

For now, we only have a CLI that let you select a pre-listed project manually. It have some level of automatic Node version handling, but just use the LTS if don't find an NVM file in the project. Only running the conventional "dev" snippet 