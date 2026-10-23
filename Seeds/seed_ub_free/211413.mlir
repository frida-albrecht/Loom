module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<168> : tensor<7x7x10x7xi64>}> : () -> tensor<7x7x10x7xi64>
    %1 = "tosa.const"() <{values = dense<1.969600e+02> : tensor<2x10x10xf32>}> : () -> tensor<2x10x10xf32>
    %2 = tosa.reduce_min %0 {axis = 2 : i32} : (tensor<7x7x10x7xi64>) -> tensor<7x7x1x7xi64>
    %3 = tosa.const_shape  {values = dense<[7, 49]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.reshape %2, %3 : (tensor<7x7x1x7xi64>, !tosa.shape<2>) -> tensor<7x49xi64>
    %5 = tosa.reciprocal %1 : (tensor<2x10x10xf32>) -> tensor<2x10x10xf32>
    %cast = tensor.cast %4 : tensor<7x49xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<2x10x10xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

