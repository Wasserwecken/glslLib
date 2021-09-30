# GLSL function collection
This repository includes many functions that I encountered through programming with shaders. These where created or added when i was working [this project](https://github.com/Wasserwecken/raytracingshader), [that project](https://github.com/Wasserwecken/bachelorthesis) and [this one](https://github.com/Wasserwecken/ACG). Im using this to avoid searching through old projects, when Im tinkering around with new shader code, to find already written algorithm's.

All relevant functions are located in the directory `./lib/`

The functions are NOT optimized for speed. The intend is to represent the idea of the algorithms and to be very readable, so the functions can be easily modified and optimized for its specific use in a actual project then.

The library also depends on itself. Many functions using functions that are defined in another file. They can be simply copied to make the actual function work in another project.

All functions definitions are using only atomic types that are already provided by GLSL and no return value. This is done to avoid dependencies to structures that have to be copied then to, and no return value is used to have a uniform appearance and its almost ready to be imported to unity shader graph.

## Where does the code come from?
Most of the algorithms are obviously not from my hand. I encountered the most through tutorials and searching form them. In many cases the source is annotated as comment. But the main sources are:

- https://www.shadertoy.com/
- https://thebookofshaders.com/
- https://learnopengl.com/
- https://iquilezles.org/
- https://math.stackexchange.com/
- https://stackoverflow.com/

## Function tests / validation
There are for some of the functions tests to validate their result.
These can be found the the directory `./tests/`. They can be executed with:
- Visual studio code
- Shadertoy Extension

Here are some tests:
![Distance fields](/.doc/df.jpg)
![Vogel points](/.doc/dist.jpg)
![Noise](/.doc/noise.jpg)
![Easing](/.doc/ease.jpg)
![Random](/.doc/rand.jpg)
