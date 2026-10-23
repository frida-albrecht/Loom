module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.952200e+02> : tensor<7x7x4x10xf32>}> : () -> tensor<7x7x4x10xf32>
    %1 = "tosa.const"() <{values = dense<114> : tensor<10x5x5x9xi32>}> : () -> tensor<10x5x5x9xi32>
    %2 = "tosa.const"() <{values = dense<88> : tensor<10x1x1x9xi32>}> : () -> tensor<10x1x1x9xi32>
    %3 = tosa.const_shape  {values = dense<[1, 1, 3, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.tile %0, %3 : (tensor<7x7x4x10xf32>, !tosa.shape<4>) -> tensor<7x7x12x20xf32>
    %5 = tosa.reciprocal %4 : (tensor<7x7x12x20xf32>) -> tensor<7x7x12x20xf32>
    %6 = tosa.intdiv %1, %2 : (tensor<10x5x5x9xi32>, tensor<10x1x1x9xi32>) -> tensor<10x5x5x9xi32>
    %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %8 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %9 = tosa.negate %5, %7, %8 : (tensor<7x7x12x20xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<7x7x12x20xf32>
    %10 = tosa.reciprocal %9 : (tensor<7x7x12x20xf32>) -> tensor<7x7x12x20xf32>
    %cast = tensor.cast %6 : tensor<10x5x5x9xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<7x7x12x20xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

