module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<140> : tensor<4x4x2xi32>}> : () -> tensor<4x4x2xi32>
    %1 = "tosa.const"() <{values = dense<77> : tensor<4x4x2xi32>}> : () -> tensor<4x4x2xi32>
    %2 = tosa.minimum %0, %1 : (tensor<4x4x2xi32>, tensor<4x4x2xi32>) -> tensor<4x4x2xi32>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<4x4x2xi32>) -> tensor<4x4x2xi32>
    %4 = tosa.reduce_sum %3 {axis = 1 : i32} : (tensor<4x4x2xi32>) -> tensor<4x1x2xi32>
    %5 = tosa.reduce_max %4 {axis = 0 : i32} : (tensor<4x1x2xi32>) -> tensor<1x1x2xi32>
    %6 = tosa.minimum %5, %5 : (tensor<1x1x2xi32>, tensor<1x1x2xi32>) -> tensor<1x1x2xi32>
    %cast = tensor.cast %6 : tensor<1x1x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

