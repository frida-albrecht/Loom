module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-34> : tensor<4x4xi16>}> : () -> tensor<4x4xi16>
    %1 = tosa.argmax %0 {axis = 1 : i32} : (tensor<4x4xi16>) -> tensor<4xi32>
    %2 = tosa.concat %1, %1 {axis = 0 : i32} : (tensor<4xi32>, tensor<4xi32>) -> tensor<8xi32>
    %cast = tensor.cast %2 : tensor<8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

