module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<38> : tensor<1x2x3x4x5xi32>}> : () -> tensor<1x2x3x4x5xi32>
    %1 = "tosa.const"() <{values = dense<-138> : tensor<1x2x3x4x5xi32>}> : () -> tensor<1x2x3x4x5xi32>
    %2 = "tosa.const"() <{values = dense<-111> : tensor<1x2x3x4x5xi32>}> : () -> tensor<1x2x3x4x5xi32>
    %3 = linalg.elementwise kind=#linalg.elementwise_kind<mul> ins(%0, %1 : tensor<1x2x3x4x5xi32>, tensor<1x2x3x4x5xi32>) outs(%2 : tensor<1x2x3x4x5xi32>) -> tensor<1x2x3x4x5xi32>
    %cast = tensor.cast %3 : tensor<1x2x3x4x5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

