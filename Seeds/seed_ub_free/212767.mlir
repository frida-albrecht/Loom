module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<17> : tensor<6x4x4x7xi8>}> : () -> tensor<6x4x4x7xi8>
    %1 = tosa.argmax %0 {axis = 3 : i32} : (tensor<6x4x4x7xi8>) -> tensor<6x4x4xi32>
    %2 = tosa.argmax %1 {axis = 0 : i32} : (tensor<6x4x4xi32>) -> tensor<4x4xi32>
    %3 = tosa.minimum %2, %2 : (tensor<4x4xi32>, tensor<4x4xi32>) -> tensor<4x4xi32>
    %cast = tensor.cast %3 : tensor<4x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

