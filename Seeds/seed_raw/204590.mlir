module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<14> : tensor<9x1x9x6xi8>}> : () -> tensor<9x1x9x6xi8>
    %1 = "tosa.const"() <{values = dense<13> : tensor<9x1x9x1xi8>}> : () -> tensor<9x1x9x1xi8>
    %2 = tosa.maximum %0, %1 : (tensor<9x1x9x6xi8>, tensor<9x1x9x1xi8>) -> tensor<9x1x9x6xi8>
    %3 = "tosa.const"() <{values = dense<[0, 3, 1, 2]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %4 = tosa.transpose %2 {perms = array<i32: 0, 3, 1, 2>} : (tensor<9x1x9x6xi8>) -> tensor<9x6x1x9xi8>
    %5 = tosa.add %4, %4 : (tensor<9x6x1x9xi8>, tensor<9x6x1x9xi8>) -> tensor<9x6x1x9xi8>
    %cast = tensor.cast %5 : tensor<9x6x1x9xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

