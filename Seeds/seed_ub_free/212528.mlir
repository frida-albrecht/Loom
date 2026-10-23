module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-45> : tensor<3xi32>}> : () -> tensor<3xi32>
    %1 = tosa.reverse %0 {axis = 0 : i32} : (tensor<3xi32>) -> tensor<3xi32>
    %2 = tosa.reduce_min %1 {axis = 0 : i32} : (tensor<3xi32>) -> tensor<1xi32>
    %cast = tensor.cast %2 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

