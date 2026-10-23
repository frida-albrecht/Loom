module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-103> : tensor<1x3x9x2xi32>}> : () -> tensor<1x3x9x2xi32>
    %1 = tosa.reverse %0 {axis = 3 : i32} : (tensor<1x3x9x2xi32>) -> tensor<1x3x9x2xi32>
    %2 = tosa.reduce_product %1 {axis = 2 : i32} : (tensor<1x3x9x2xi32>) -> tensor<1x3x1x2xi32>
    %cast = tensor.cast %2 : tensor<1x3x1x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

