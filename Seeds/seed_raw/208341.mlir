module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-52> : tensor<7x4xi32>}> : () -> tensor<7x4xi32>
    %1 = "tosa.const"() <{values = dense<-161> : tensor<7x1xi32>}> : () -> tensor<7x1xi32>
    %2 = tosa.sub %0, %1 : (tensor<7x4xi32>, tensor<7x1xi32>) -> tensor<7x4xi32>
    %3 = tosa.sub %2, %2 : (tensor<7x4xi32>, tensor<7x4xi32>) -> tensor<7x4xi32>
    %4 = tosa.add %3, %2 : (tensor<7x4xi32>, tensor<7x4xi32>) -> tensor<7x4xi32>
    %cast = tensor.cast %4 : tensor<7x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

