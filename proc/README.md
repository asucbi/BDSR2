## Proc folder

This is where we can dump scripts or anything else we needed to create to process and create datasets. Best practice would be to not include the data files here, especially if they are large, but rather download them from within scripts. If that's not possible, put them in a `/local` or `/data` folder within the relevant subfolder and the .gitignore will skip them.
