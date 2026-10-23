module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.230600e+02> : tensor<4xf32>}> : () -> tensor<4xf32>
    %1 = "tosa.const"() <{values = dense<-41> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<-163> : tensor<i32>}> : () -> tensor<i32>
    %3 = tosa.rsqrt %0 : (tensor<4xf32>) -> tensor<4xf32>
    %4 = tosa.intdiv %1, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %5 = tosa.identity %3 : (tensor<4xf32>) -> tensor<4xf32>
    %6 = tosa.maximum %5, %5 : (tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<4xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

