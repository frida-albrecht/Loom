module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-61> : tensor<7x7xi32>}> : () -> tensor<7x7xi32>
    %1 = "tosa.const"() <{values = dense<-37> : tensor<7x1xi32>}> : () -> tensor<7x1xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<7x1xi32>}> : () -> tensor<7x1xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<7x1xi32>}> : () -> tensor<7x1xi32>
    %clamped_lower = tosa.maximum %1, %c0 : (tensor<7x1xi32>, tensor<7x1xi32>) -> tensor<7x1xi32>
    %clamped_shift = tosa.minimum %clamped_lower, %c31 : (tensor<7x1xi32>, tensor<7x1xi32>) -> tensor<7x1xi32>
    %2 = tosa.logical_left_shift %0, %clamped_shift : (tensor<7x7xi32>, tensor<7x1xi32>) -> tensor<7x7xi32>
    %cast = tensor.cast %2 : tensor<7x7xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}