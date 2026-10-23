module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-112> : tensor<10x5xi32>}> : () -> tensor<10x5xi32>
    %1 = "tosa.const"() <{values = dense<46> : tensor<10x1xi32>}> : () -> tensor<10x1xi32>
    %c1 = "tosa.const"() <{values = dense<0> : tensor<10x1xi32>}> : () -> tensor<10x1xi32>
    %c2 = "tosa.const"() <{values = dense<31> : tensor<10x1xi32>}> : () -> tensor<10x1xi32>
    %s1 = tosa.maximum %1, %c1 : (tensor<10x1xi32>, tensor<10x1xi32>) -> tensor<10x1xi32>
    %s2 = tosa.minimum %s1, %c2 : (tensor<10x1xi32>, tensor<10x1xi32>) -> tensor<10x1xi32>
    %2 = tosa.arithmetic_right_shift %0, %s2 {round = true} : (tensor<10x5xi32>, tensor<10x1xi32>) -> tensor<10x5xi32>
    %cast = tensor.cast %2 : tensor<10x5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}