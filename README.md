# Introduction

This is a simple introduction to show how matlab can be integrated with your papers on LaTeX.

The idea here is that you are able to link your simulation code with your paper text, such that whenever you run a simulation you don't have to do anything, and your paper is updated.

Note that, this does not work with overleaf, since you must update your files there directly. There are ways of getting overleaf to work with git, such that you can also automate that, but it is part of their paid subscription package. In any case, it is better to get used to configuring and maintaing a local LaTeX environment, as this will give you more freedom in the long run.

The first thing to do, is make sure your environment is properly setup. For that, read the [Dependencies](#Dependencies) section.

# Dependencies
* Matlab
* matlab2tikz
* LaTeX
    Packages:
    * pgfplots
    * TikZ

This tutorial assumes that you have a LaTeX environment configured and that you know how to install and update packages. If that is not the case, you first need to sort this out.

## matlab2tikz
`matlab2tikz` is just a collection of .m files which contain the code you need. The reason you need to "install" it separetely is because it is not part of the official Mathworks libraries. It is maintained by the community.

### Obtaining the library
There are two options for getting `matlab2tikz`: 
1. Clone their github repository:

`git clone git@github.com:matlab2tikz/matlab2tikz.git`

2. Download the code directly from their page github repository:

    1. Go to the [repository](https://github.com/matlab2tikz/matlab2tikz)
    2. Select `clone or download`
    3. Click `Download ZIP`
    4. Extract the zip file 

### Add the src location to your Matlab PATH.
Remember to add the src location to your Matlab PATH:
1. On Matlab, click on `Set Path`
2. Select `add folder`
3. Select the location where you have the source code for `matlab2tikz`. It is the `src` folder inside the `matlab2tikz` folder you extracted or cloned with git.
4. Click `open`
5. Click `save`
6. Click `close`

