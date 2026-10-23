module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-103> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<165> : tensor<i32>}> : () -> tensor<i32>
    %2 = tosa.intdiv %0, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %3 = tosa.clamp %2 {max_val = -5 : i32, min_val = -51 : i32} : (tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %3 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

