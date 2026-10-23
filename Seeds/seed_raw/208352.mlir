module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<144> : tensor<6x9x5x4xi16>}> : () -> tensor<6x9x5x4xi16>
    %1 = tosa.argmax %0 {axis = 2 : i32} : (tensor<6x9x5x4xi16>) -> tensor<6x9x4xi32>
    %2 = tosa.intdiv %1, %1 : (tensor<6x9x4xi32>, tensor<6x9x4xi32>) -> tensor<6x9x4xi32>
    %3 = tosa.reverse %2 {axis = 2 : i32} : (tensor<6x9x4xi32>) -> tensor<6x9x4xi32>
    %4 = tosa.reduce_sum %3 {axis = 2 : i32} : (tensor<6x9x4xi32>) -> tensor<6x9x1xi32>
    %5 = tosa.concat %4, %4 {axis = 1 : i32} : (tensor<6x9x1xi32>, tensor<6x9x1xi32>) -> tensor<6x18x1xi32>
    %cast = tensor.cast %5 : tensor<6x18x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

