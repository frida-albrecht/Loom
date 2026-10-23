module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9.447000e+01> : tensor<9x5xf32>}> : () -> tensor<9x5xf32>
    %1 = "tosa.const"() <{values = dense<51> : tensor<8x9xi64>}> : () -> tensor<8x9xi64>
    %2 = tosa.rsqrt %0 : (tensor<9x5xf32>) -> tensor<9x5xf32>
    %3 = tosa.const_shape  {values = dense<[2, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.tile %2, %3 : (tensor<9x5xf32>, !tosa.shape<2>) -> tensor<18x5xf32>
    %5 = tosa.const_shape  {values = dense<2> : tensor<2xindex>} : () -> !tosa.shape<2>
    %6 = tosa.tile %4, %5 : (tensor<18x5xf32>, !tosa.shape<2>) -> tensor<36x10xf32>
    %7 = tosa.clz %1 : (tensor<8x9xi64>) -> tensor<8x9xi64>
    %8 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %9 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %10 = tosa.negate %6, %8, %9 : (tensor<36x10xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<36x10xf32>
    %11 = tosa.rsqrt %10 : (tensor<36x10xf32>) -> tensor<36x10xf32>
    %cast = tensor.cast %7 : tensor<8x9xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %11 : tensor<36x10xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

