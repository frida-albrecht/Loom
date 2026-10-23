module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-41> : tensor<i32>}> : () -> tensor<i32>
    %1 = tosa.clamp %0 {max_val = 93 : i32, min_val = -4 : i32} : (tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %1 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

