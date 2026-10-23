module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.770400e+02> : tensor<6x8xf32>}> : () -> tensor<6x8xf32>
    %1 = tosa.floor %0 : (tensor<6x8xf32>) -> tensor<6x8xf32>
    %2 = tosa.argmax %1 {axis = 1 : i32} : (tensor<6x8xf32>) -> tensor<6xi32>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<6xi32>) -> tensor<6xi32>
    %cast = tensor.cast %3 : tensor<6xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

