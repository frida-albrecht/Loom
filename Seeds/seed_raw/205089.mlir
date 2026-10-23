module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-41> : tensor<9x4xi16>}> : () -> tensor<9x4xi16>
    %1 = "tosa.const"() <{values = dense<-118> : tensor<9x1xi16>}> : () -> tensor<9x1xi16>
    %2 = tosa.bitwise_or %0, %1 : (tensor<9x4xi16>, tensor<9x1xi16>) -> tensor<9x4xi16>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<9x4xi16>) -> tensor<4xi32>
    %cast = tensor.cast %3 : tensor<4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

