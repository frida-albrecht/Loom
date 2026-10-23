module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<10x4x3x2xi1>}> : () -> tensor<10x4x3x2xi1>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<10x4x3x2xi1>) -> tensor<4x3x2xi32>
    %2 = tosa.concat %1, %1 {axis = 1 : i32} : (tensor<4x3x2xi32>, tensor<4x3x2xi32>) -> tensor<4x6x2xi32>
    %3 = tosa.concat %2, %2 {axis = 0 : i32} : (tensor<4x6x2xi32>, tensor<4x6x2xi32>) -> tensor<8x6x2xi32>
    %cast = tensor.cast %3 : tensor<8x6x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

