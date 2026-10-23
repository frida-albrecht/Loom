module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-71> : tensor<10xi32>}> : () -> tensor<10xi32>
    %1 = "tosa.const"() <{values = dense<-141> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = "tosa.const"() <{values = dense<6.399000e+01> : tensor<5x8xf32>}> : () -> tensor<5x8xf32>
    %3 = tosa.maximum %0, %1 : (tensor<10xi32>, tensor<1xi32>) -> tensor<10xi32>
    %4 = tosa.add %3, %3 : (tensor<10xi32>, tensor<10xi32>) -> tensor<10xi32>
    %5 = tosa.ceil %2 : (tensor<5x8xf32>) -> tensor<5x8xf32>
    %6 = tosa.abs %4 : (tensor<10xi32>) -> tensor<10xi32>
    %7 = tosa.reduce_product %6 {axis = 0 : i32} : (tensor<10xi32>) -> tensor<1xi32>
    %8 = tosa.minimum %7, %7 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %9 = tosa.concat %8, %8 {axis = 0 : i32} : (tensor<1xi32>, tensor<1xi32>) -> tensor<2xi32>
    %cast = tensor.cast %5 : tensor<5x8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<2xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

