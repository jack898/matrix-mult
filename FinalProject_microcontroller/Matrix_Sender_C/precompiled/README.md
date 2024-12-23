# Precompiled Matrix Sender Test Cases

### Description
These are some precompiled matrix test cases for the multiplier. For each case below, R is the product of the two matrices.

Each number for each matrix is stored in an unsigned 8-bit binary format.

**itimesi.uf2:** 
$$
R = \begin{pmatrix}
  1 & 0 & 0 \\
  0 & 1 & 0 \\
  0 & 0 & 1
\end{pmatrix} \begin{pmatrix}
  1 & 0 & 0 \\
  0 & 1 & 0 \\
  0 & 0 & 1
\end{pmatrix}
$$

**itimesfull.uf2:**
$$
R = \begin{pmatrix}
  1 & 0 & 0 \\
  0 & 1 & 0 \\
  0 & 0 & 1
\end{pmatrix} \begin{pmatrix}
  255 & 255 & 255 \\
  255 & 255 & 255 \\
  255 & 255 & 255
\end{pmatrix}
$$

**shiftvals.uf2:**
$$
R = \begin{pmatrix}
  1 & 0 & 0 \\
  0 & 1 & 0 \\
  0 & 0 & 60
\end{pmatrix} \begin{pmatrix}
  1 & 0 & 0 \\
  0 & 0 & 1 \\
  0 & 1 & 0
\end{pmatrix}
$$

**transition.uf2:** Each value is arbitrarily chosen 0 < val < 256, but the clock is slowed greatly so the matrices loading in can be visualized.

**randColors.uf2:** Again arbitrarily chosen values 0 < val < 256, just makes some neat colors if visualized using VGA!

**accel.uf2:** TODO (accelerated clock??)