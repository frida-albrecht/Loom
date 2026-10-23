module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-134> : tensor<5xi32>}> : () -> tensor<5xi32>
    %1 = tosa.identity %0 : (tensor<5xi32>) -> tensor<5xi32>
    %2 = tosa.reverse %1 {axis = 0 : i32} : (tensor<5xi32>) -> tensor<5xi32>
    %cast = tensor.cast %2 : tensor<5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

