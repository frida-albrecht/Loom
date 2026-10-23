module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<23> : tensor<7x1x6xi32>}> : () -> tensor<7x1x6xi32>
    %1 = "tosa.const"() <{values = dense<85> : tensor<31x1x6xi32>}> : () -> tensor<31x1x6xi32>
    %2 = tosa.concat %0, %1 {axis = 0 : i32} : (tensor<7x1x6xi32>, tensor<31x1x6xi32>) -> tensor<38x1x6xi32>
    %3 = tosa.bitwise_xor %2, %2 : (tensor<38x1x6xi32>, tensor<38x1x6xi32>) -> tensor<38x1x6xi32>
    %4 = tosa.argmax %3 {axis = 1 : i32} : (tensor<38x1x6xi32>) -> tensor<38x6xi32>
    %cast = tensor.cast %4 : tensor<38x6xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

