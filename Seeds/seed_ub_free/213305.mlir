module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<62> : tensor<1x10xi32>}> : () -> tensor<1x10xi32>
    %1 = "tosa.const"() <{values = dense<-65> : tensor<1x10xi32>}> : () -> tensor<1x10xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<1x10xi32>, tensor<1x10xi32>) -> tensor<1x10xi32>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<1x10xi32>) -> tensor<1x10xi32>
    %4 = tosa.identity %3 : (tensor<1x10xi32>) -> tensor<1x10xi32>
    %cast = tensor.cast %4 : tensor<1x10xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

