module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-169> : tensor<1x6x5xi64>}> : () -> tensor<1x6x5xi64>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<1x6x5xi64>) -> tensor<6x5xi32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = tosa.negate %1, %2, %3 : (tensor<6x5xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<6x5xi32>
    %cast = tensor.cast %4 : tensor<6x5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

