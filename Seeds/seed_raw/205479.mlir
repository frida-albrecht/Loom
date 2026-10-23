module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<59> : tensor<8x2xi32>}> : () -> tensor<8x2xi32>
    %1 = "tosa.const"() <{values = dense<-144> : tensor<76x2xi32>}> : () -> tensor<76x2xi32>
    %2 = tosa.concat %0, %1 {axis = 0 : i32} : (tensor<8x2xi32>, tensor<76x2xi32>) -> tensor<84x2xi32>
    %cast = tensor.cast %2 : tensor<84x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

