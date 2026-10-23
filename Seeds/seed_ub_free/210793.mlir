module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<13> : tensor<4xi16>}> : () -> tensor<4xi16>
    %1 = "tosa.const"() <{values = dense<160> : tensor<1xi16>}> : () -> tensor<1xi16>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<4xi16>, tensor<1xi16>) -> tensor<4xi16>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<4xi16>) -> tensor<i32>
    %4 = tosa.argmax %2 {axis = 0 : i32} : (tensor<4xi16>) -> tensor<i32>
    %5 = tosa.arithmetic_right_shift %3, %4 {round = true} : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %5 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

