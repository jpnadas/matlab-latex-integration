# Introduction

This is a simple introduction to show how Matlab can be integrated with your papers on LaTeX.

The idea here is that you are able to link your simulation code with your paper text, such that whenever you run a simulation you don't have to do anything, and your paper is updated.

Note that, this does not work with overleaf, since you must update your files there directly. There are ways of getting overleaf to work with git, such that you can also automate that, but it is part of their paid subscription package. In any case, it is better to get used to configuring and maintaing a local LaTeX environment, as this will give you more freedom in the long run.

The first thing to do, is make sure your environment is properly setup. For that, read the [Dependencies](#Dependencies) section.

# Dependencies
* Matlab
    * matlab2tikz
    * TableRow
    * printTable
* LaTeX
    Packages:
    * pgfplots
    * TikZ
    * booktabs
    * threeparttable
    * amsmath

This tutorial assumes that you have a LaTeX environment configured and that you know how to install and update packages. If that is not the case, you first need to sort this out.
`TableRow` and `printTable` are a class and a function (respectively) provided in this repository. Make sure to add them to your path.

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

# Explanation
Below, I will give a brief explanation on how to do the same thing as this example on your own paper.

## The directory structure
Create the following structure for your project:

```
root_dir/
    simulations/
    paper/
        figures/
        tables/
```

## The Matlab code

### Figures
`matlab2tikz` is a function which gets the active figure in Matlab and exports it to TikZ (a graphical library for LaTeX).

In order to use `matlab2tikz`, simply call it giving as argument the name of the destination file. Since we want to tie our simulation with our paper, we give a path to a file inside the directory with the LaTeX source.

```Matlab
figure
plot(t, x)
matlab2tikz('../paper/figures/my_figure.tex')
```

The function is very good at preserving matlab style configurations on the figure. On the example I have set the grid, labels, legends, and everything was preserved to TikZ.

### Table
To generate the table automatically, I created a class to hold the information desired and a function to print the table according to a list of rows.

To use it, create your rows and add them to an array:

```Matlab
array(1) = TableRow('Description text', value, 'unit', 'variable name', 'reference')
array(end + 1) = TableRow('Description text', value, 'unit', 'variable name', 'reference')
```

Note that, the reference parameter refers to the bib handle value for the reference where you obtained that parameter. If you want, you may leave it blank (`''`). Just remember that it is better if you can find a source for the value you chose for your simulation.

Once you have added all your parameters, add the instruction to generate the table:

```Matlab
printTable(array,'../paper/tables/params', 'tb:params')
```

Note that, we gave the `'tb:params'` label to our table. This will be usefull to reference it on the text of our paper.

## The LaTeX document

### Preamble
On the LaTeX preamble, import the dependency packages:

```Latex
\usepackage{tikz}
\usepackage{pgfplots}
\usepackage{lipsum}
\usepackage[flushleft]{threeparttable}
\usepackage{booktabs}
\usepackage{amsmath}
```

### Table of parameters
When you want to include the table of simulation parameters, use the following:

```Latex
\begin{table}
    \input{tables/params.tex}
\end{table}
```

Note that, the file name can be configured by you when you prepare the matlab code.

To reference it in the text, use the label defined in Matlab. In the example we use `tb:params`.

### Figures

When you want to inlcude your generated figures, use the following code:

```Latex
\begin{figure}[t!]
    \centering
    \resizebox{\columnwidth}{!}{\input{figures/my_figure.tex}}
    \caption{My caption.}\label{fig:my_fig}
\end{figure}
```

