First, my file structure is created with eli/setup/structure.fish \
All the other parts of my system will depend on the paths defined in there.

The next step is ./eli/setup/dode.fish \
This is NOT supposed to be a script to straight up run — the `return` at the start suggests this. \
It's a collection of program setups, ideally expressed in shell commands I can execute to fully set up a program, but sometimes including manual steps, or references to my own notes if the setup is particularly complicated (like for the browser for instance).  \
By design, I don't hold some list of programs to definitely install; I want to be handpicking the programs that I actually *want* on my system, search for them in dode, and set them up individually.

Part of the benefit of reinstalling (what dode is trying to help make nicer) is that you get to completely debloat your system. \
Doesn't make sense to rebloat it with some form of “install everything I used to have” approach. \
And I **really** don't wanna maintain a list of software I definitely want. I feel like it'd change way too often, and become a big bother in the process.
To protect me from a process that should ideally never happen again in my life anyway :p

I back up my dotfiles in a very minute way not because I often need to reinstate my system, but because I'm not stupid enough to think that nothing bad will ever happen, to warrant a reinstall in the first place.

./eli/setup/pack.fish is basically another dode, but focused on setting up programming languages and/or package managers. I'm not even sure it's a good idea to have this separated, tbh. \
The `main` section reveals a bit of a lie — here are two lists of packages I definitely always want on my system 💀 \
Okay but in my defence, I'm actively moving away from the idea, and I don't remember the last time I added something into there.

Magazines are used there, and here's my [blog post](https://axlefublr.github.io/magazines/) explaining the concept. \
They'll come up in all sorts of places.

The section headers I don't make manually — I have a hotkey that wraps the selection in such a way that it ends up in the middle of a bunch of `-`s. \
I then have a picker in my [helix fork](https://github.com/Axlefublr/helix) that lets me search through these `-` delimited sections, more directly.

Next spot to visit is ./fish/fun/ \
I love fish shell, and write most of my system's functionality in it.
Whenever you see me do `fish -c some_function`, `some_function` will be somewhere in ./fish/fun/

./eli/ contains my scripts! \
[Here's why it's not called “scripts”](https://axlefublr.github.io/optimizing-paths) \
Unless another language is more appropriate for the job, I prefer to write functionality in a fish *function*, rather than a separate script. So this spot will be comparatively unpopulated.

./eli/ is added to $PATH, so I can use the scripts in it directly. If you ever see me call a binary with an extension, that you don't recognize, good idea to check in ./eli/

./eli/fool/ is a concept of making a wrapper over a program, *fool*ing it into providing you some extra behavior. \
Imagine doing something like making `git clone` automatically `cd` you into the newly cloned directory — *that*.

Currently, ./nu/lvoc/ contains both nushell scripts and nushell libraries. \
I thought I would source nushell scripts into a nu shell in development more often than I *actually* do, so I'll probably move the scripts into ./eli/, and make ./nu/lvoc/ contain only the nushell libraries.

Incidentally, most of my nushell config isn't in my nushell config: I [forked nushell](https://github.com/Axlefublr/nushell) to change the defaults to my preferences *in the source*, because the current way that configuration works in nushell is a bit of a massive pain.
Yes, to the degree that forking is less of a massive pain.
So if you wanna make your nushell look like mine, look at the diff of the fork ig? lol :D

Final significant piece of the puzzle is ./systemd/ — I store all the systemd unit configurations / overrides here, and they are installed / applied either by the program's dode, or by the systemd dode.
