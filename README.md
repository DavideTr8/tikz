# TikZ Graphics Project

This project is set up for creating TikZ diagrams and graphics for LaTeX documents.

## Project Structure

```
tikz/
├── README.md              # This file
├── main.tex               # Main LaTeX document
├── tikz/                  # Directory for TikZ source files
│   ├── examples/          # Example TikZ diagrams
│   └── figures/           # Your custom TikZ figures
├── output/                # Compiled PDFs and intermediate files
├── assets/                # Images and other assets
├── styles/                # Custom TikZ styles and libraries
├── Makefile              # Build automation
└── .gitignore            # Git ignore file
```

## Getting Started

1. **Create a new TikZ diagram:**
   - Add a new `.tex` file in the `tikz/figures/` directory
   - Include it in `main.tex` using `\input{tikz/figures/yourfile.tex}`

2. **Build the project:**
   ```bash
   make                    # Build main document
   make clean             # Clean intermediate files
   make examples          # Build example diagrams
   ```

3. **Standalone diagrams:**
   - Use the provided template in `tikz/examples/` for standalone diagrams
   - Compile individual diagrams: `pdflatex tikz/figures/yourfile.tex`

## Dependencies

Make sure you have the following LaTeX packages installed:
- `tikz`
- `pgfplots`
- `tikz-cd` (for commutative diagrams)
- `circuitikz` (for circuit diagrams)
- `tikz-3dplot` (for 3D graphics)

## Tips

- Use the `styles/` directory to define reusable TikZ styles
- Keep individual TikZ files focused on single diagrams
- Use meaningful names for your TikZ files
- Comment your TikZ code for future reference
