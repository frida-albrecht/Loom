module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-102> : tensor<2xi32>}> : () -> tensor<2xi32>
    %1 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<2xi32>) -> tensor<1xi32>
    %cast = tensor.cast %1 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

