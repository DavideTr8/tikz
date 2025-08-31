# Quick Start Guide for TikZ Project

## Creating Your First TikZ Diagram

1. **Create a new TikZ file:**
   ```bash
   cp tikz/figures/template.tex tikz/figures/my-diagram.tex
   ```

2. **Edit your diagram:**
   Open `tikz/figures/my-diagram.tex` and replace the example content with your TikZ code.

3. **Include it in the main document:**
   Add this to `main.tex`:
   ```latex
   \begin{figure}[h]
       \centering
       \input{tikz/figures/my-diagram.tex}
       \caption{My custom diagram}
       \label{fig:my-diagram}
   \end{figure}
   ```

4. **Compile the document:**
   ```bash
   make
   ```

## Useful TikZ Commands

### Basic Drawing
- `\draw (0,0) -- (1,1);` - Draw a line
- `\draw (0,0) rectangle (2,1);` - Draw a rectangle
- `\draw (0,0) circle (1);` - Draw a circle
- `\fill[color] (0,0) circle (0.5);` - Fill a shape

### Nodes
- `\node at (0,0) {Text};` - Place text at coordinates
- `\node[style] (name) at (0,0) {Text};` - Styled node with name

### Using Custom Styles
The project includes predefined styles in `styles/common-styles.tex`:
- `\node[process] {Process};` - Blue process box
- `\node[decision] {Decision};` - Orange diamond
- `\node[startstop] {Start/End};` - Green rounded box
- `\draw[arrow] (a) -- (b);` - Arrow between nodes

### Colors
Predefined colors available:
- `primaryblue`, `primaryred`, `primarygreen`
- `primaryorange`, `primarypurple`
- `lightgray`, `darkgray`

## Build Commands

- `make` - Build main document
- `make clean` - Remove temporary files
- `make examples` - Compile standalone examples
- `make help` - Show all available commands

## Tips

1. **Keep diagrams modular** - One diagram per file
2. **Use meaningful filenames** - `network-topology.tex` instead of `diagram1.tex`
3. **Comment your code** - Future you will thank you
4. **Test frequently** - Compile often to catch errors early
5. **Use version control** - The `.gitignore` is already set up for you
