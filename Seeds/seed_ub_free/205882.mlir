module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<95.8099975> : tensor<5x9xf32>}> : () -> tensor<5x9xf32>
    %1 = "tosa.const"() <{values = dense<-1.200400e+02> : tensor<5x1xf32>}> : () -> tensor<5x1xf32>
    %2 = tosa.greater_equal %0, %1 : (tensor<5x9xf32>, tensor<5x1xf32>) -> tensor<5x9xi1>
    %3 = tosa.argmax %2 {axis = 1 : i32} : (tensor<5x9xi1>) -> tensor<5xi32>
    %cast = tensor.cast %3 : tensor<5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

