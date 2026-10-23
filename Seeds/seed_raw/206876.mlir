module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-99> : tensor<8x10x1x2xi32>}> : () -> tensor<8x10x1x2xi32>
    %1 = tosa.reduce_sum %0 {axis = 2 : i32} : (tensor<8x10x1x2xi32>) -> tensor<8x10x1x2xi32>
    %2 = tosa.maximum %1, %1 : (tensor<8x10x1x2xi32>, tensor<8x10x1x2xi32>) -> tensor<8x10x1x2xi32>
    %cast = tensor.cast %2 : tensor<8x10x1x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

