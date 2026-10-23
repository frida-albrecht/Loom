module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<112> : tensor<10x9x2x1xi32>}> : () -> tensor<10x9x2x1xi32>
    %1 = "tosa.const"() <{values = dense<-111> : tensor<10x1x2x1xi32>}> : () -> tensor<10x1x2x1xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<10x9x2x1xi32>, tensor<10x1x2x1xi32>) -> tensor<10x9x2x1xi32>
    %3 = tosa.abs %2 : (tensor<10x9x2x1xi32>) -> tensor<10x9x2x1xi32>
    %cast = tensor.cast %3 : tensor<10x9x2x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

