module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<34> : tensor<6x10x4xi64>}> : () -> tensor<6x10x4xi64>
    %1 = "tosa.const"() <{values = dense<-59> : tensor<1x1x4xi64>}> : () -> tensor<1x1x4xi64>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<6x10x4xi64>, tensor<1x1x4xi64>) -> tensor<6x10x4xi64>
    %3 = tosa.argmax %2 {axis = 1 : i32} : (tensor<6x10x4xi64>) -> tensor<6x4xi32>
    %cast = tensor.cast %3 : tensor<6x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

