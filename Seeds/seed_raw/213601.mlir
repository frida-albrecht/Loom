module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<139> : tensor<6x9x6x1xi32>}> : () -> tensor<6x9x6x1xi32>
    %1 = "tosa.const"() <{values = dense<-161> : tensor<6x1x6x1xi32>}> : () -> tensor<6x1x6x1xi32>
    %2 = tosa.sub %0, %1 : (tensor<6x9x6x1xi32>, tensor<6x1x6x1xi32>) -> tensor<6x9x6x1xi32>
    %3 = tosa.reduce_min %2 {axis = 0 : i32} : (tensor<6x9x6x1xi32>) -> tensor<1x9x6x1xi32>
    %4 = "tosa.const"() <{values = dense<[0, 3, 1, 2]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %5 = tosa.transpose %3 {perms = array<i32: 0, 3, 1, 2>} : (tensor<1x9x6x1xi32>) -> tensor<1x1x9x6xi32>
    %cast = tensor.cast %5 : tensor<1x1x9x6xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

