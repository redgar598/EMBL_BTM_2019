# Opening the shell
In the 70ths opening the shell was not something you did, but something that happenend.

Now we just have to search for "shell" or on Mac "Terminal" and a black window will
open for us.

TODO: [Image of MAc terminal!]

If you want go ahead and make the shell full screen. What can you see?

## The prompt

What can we see? In my terminal I see:

```
paul@laptop: ~$
```
So its me (paul) *at* my laptop in the location *~* (UNIX for: Home folder) and waiting for a command *$*.

So its waiting for a command. Lets type something. What about **hello**?

```
bash: hello: command not found
```

Fair enough. 

### A safety note
You can type most commands and nothing bad will happen. The only command you 
should really be carefull with is **rm**. It will **r**e**m**ove your files 
without putting them into the recylce bin.

**rm** is permanent. 

But all the other commands: Make a typo and you will get help.


## What now?
Lets find out what the terminal is.

Can you type
```
ls
```

What do you see?

Its your files. Right? 

The terminal really is a simple file manager. We can create files:

```
touch new_file
```

Write into files

```
echo "Hello shell,\nWhats up?" > new_file
```

And look at files:

```
cat new_file
```

(You can copy paste these commands or type them)

What just happened?

## In case of questions
The internet is your friend. All questions have been asked. Just read up and you'll be fine.

If you want to find out yourself or have a very specialized question:

```
man ls
man less
man [...]
```
Man, short for manual, will show you the help for any command.


For now lets move on with some [examples](../1_example/)










