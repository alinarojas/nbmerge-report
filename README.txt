# LaTeX Report Builder from Jupyter Notebooks

This script automates the process of combining multiple Jupyter notebooks into a single LaTeX file, optionally replacing the LaTeX preamble, and preparing it for PDF compilation.

## Requirements

- Python with:
  - [`nbmerge`](https://pypi.org/project/nbmerge/)
  - [`jupyter nbconvert`](https://nbconvert.readthedocs.io/)
- LaTeX distribution:
  - [MiKTeX](https://miktex.org/) (Windows)

## Script Usage

From the command line, call the batch script and pass all notebooks to merge **as arguments**:

```bash
build_report.bat intro.ipynb analysis.ipynb results.ipynb outro.ipynb
````

> Notebooks must be passed as command-line arguments.

This will:

1. Merge the notebooks into `latex\report.ipynb`
2. Convert that to `latex\report.tex`
3. (Optional) Replace the first N lines of the `.tex` file with the content of `header.tex`  
   → The repository includes a `header.tex` file that fully defines the LaTeX structure, including the **cover page**, **title formatting**, and **table of contents**.  
   → This file overrides the default preamble and layout inserted by `nbconvert`, giving you full control over the document's appearance.

### LaTeX Header Replacement

If a file named `header.tex` exists in the working directory, it will replace the first **392 lines** of the generated `.tex` file. Adjust the `LINES` variable in the script if your template structure changes.

## Compiling the `.tex` file

To compile the final LaTeX file into a PDF, run:

```bash
pdflatex report.tex
pdflatex report.tex
```

> Running it twice ensures that the table of contents, references, and index are properly generated and resolved.

If your file uses bibliographic references (`biblatex`, `biber`, etc.), additional steps may be required.

## Output

* `latex/report.ipynb` — merged notebook
* `latex/report.tex` — LaTeX export
* `latex/report.pdf` — final output (after compilation)

---

## Example

```bash
build_report.bat intro.ipynb chapter1.ipynb chapter2.ipynb outro.ipynb
cd latex
pdflatex report.tex
pdflatex report.tex
```

This will produce a polished PDF from your Jupyter notebook pipeline.
