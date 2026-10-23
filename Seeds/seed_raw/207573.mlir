module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-151> : tensor<5x5x9x1xi32>}> : () -> tensor<5x5x9x1xi32>
    %1 = "tosa.const"() <{values = dense<50> : tensor<1x5x1x1xi32>}> : () -> tensor<1x5x1x1xi32>
    %2 = "tosa.const"() <{values = dense<1.454100e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.bitwise_or %0, %1 : (tensor<5x5x9x1xi32>, tensor<1x5x1x1xi32>) -> tensor<5x5x9x1xi32>
    %4 = tosa.logical_right_shift %3, %3 : (tensor<5x5x9x1xi32>, tensor<5x5x9x1xi32>) -> tensor<5x5x9x1xi32>
    %5 = tosa.maximum %4, %4 : (tensor<5x5x9x1xi32>, tensor<5x5x9x1xi32>) -> tensor<5x5x9x1xi32>
    %6 = tosa.reciprocal %2 : (tensor<f32>) -> tensor<f32>
    %7 = tosa.sigmoid %6 : (tensor<f32>) -> tensor<f32>
    %8 = tosa.const_shape  {values = dense<1> : tensor<4xindex>} : () -> !tosa.shape<4>
    %9 = tosa.reshape %6, %8 : (tensor<f32>, !tosa.shape<4>) -> tensor<1x1x1x1xf32>
    %cast = tensor.cast %5 : tensor<5x5x9x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %7 : tensor<f32> to tensor<*xf32>
    %cast_1 = tensor.cast %9 : tensor<1x1x1x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

