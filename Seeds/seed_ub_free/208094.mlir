module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.681600e+02> : tensor<5x8x3x7xf32>}> : () -> tensor<5x8x3x7xf32>
    %1 = "tosa.const"() <{values = dense<1.428500e+02> : tensor<5x1x1x1xf32>}> : () -> tensor<5x1x1x1xf32>
    %2 = "tosa.const"() <{values = dense<64> : tensor<9x1xi32>}> : () -> tensor<9x1xi32>
    %3 = "tosa.const"() <{values = dense<57> : tensor<9x1xi32>}> : () -> tensor<9x1xi32>
    %4 = tosa.maximum %0, %1 : (tensor<5x8x3x7xf32>, tensor<5x1x1x1xf32>) -> tensor<5x8x3x7xf32>
    %5 = tosa.const_shape  {values = dense<[56, 15]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %6 = tosa.reshape %4, %5 : (tensor<5x8x3x7xf32>, !tosa.shape<2>) -> tensor<56x15xf32>
    %7 = tosa.floor %6 : (tensor<56x15xf32>) -> tensor<56x15xf32>
    %8 = tosa.reduce_min %7 {axis = 1 : i32} : (tensor<56x15xf32>) -> tensor<56x1xf32>
    %9 = tosa.log %8 : (tensor<56x1xf32>) -> tensor<56x1xf32>
    %10 = tosa.bitwise_or %2, %3 : (tensor<9x1xi32>, tensor<9x1xi32>) -> tensor<9x1xi32>
    %cast = tensor.cast %9 : tensor<56x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<9x1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

