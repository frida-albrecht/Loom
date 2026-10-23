module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<i1>}> : () -> tensor<i1>
    %1 = "tosa.const"() <{values = dense<-89> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<33> : tensor<i32>}> : () -> tensor<i32>
    %3 = arith.select %0, %1, %2 : tensor<i1>, tensor<i32>
    %cast = tensor.cast %3 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

