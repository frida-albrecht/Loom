module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<62> : tensor<1x5x4x8xi32>}> : () -> tensor<1x5x4x8xi32>
    %1 = "tosa.const"() <{values = dense<-1.437500e+02> : tensor<7xf32>}> : () -> tensor<7xf32>
    %2 = tosa.identity %0 : (tensor<1x5x4x8xi32>) -> tensor<1x5x4x8xi32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = tosa.negate %2, %3, %4 : (tensor<1x5x4x8xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1x5x4x8xi32>
    %6 = tosa.ceil %1 : (tensor<7xf32>) -> tensor<7xf32>
    %7 = tosa.const_shape  {values = dense<3> : tensor<4xindex>} : () -> !tosa.shape<4>
    %8 = tosa.tile %5, %7 : (tensor<1x5x4x8xi32>, !tosa.shape<4>) -> tensor<3x15x12x24xi32>
    %9 = tosa.reduce_sum %6 {axis = 0 : i32} : (tensor<7xf32>) -> tensor<1xf32>
    %10 = tosa.maximum %9, %9 : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %8 : tensor<3x15x12x24xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

