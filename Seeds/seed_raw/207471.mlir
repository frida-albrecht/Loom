module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<11> : tensor<6x7x10xi32>}> : () -> tensor<6x7x10xi32>
    %1 = "tosa.const"() <{values = dense<129> : tensor<6x10x6xi32>}> : () -> tensor<6x10x6xi32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<6x7x10xi32>, tensor<6x10x6xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<6x7x6xi32>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %7 = tosa.negate %4, %5, %6 : (tensor<6x7x6xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<6x7x6xi32>
    %8 = tosa.reduce_min %7 {axis = 0 : i32} : (tensor<6x7x6xi32>) -> tensor<1x7x6xi32>
    %cast = tensor.cast %8 : tensor<1x7x6xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

