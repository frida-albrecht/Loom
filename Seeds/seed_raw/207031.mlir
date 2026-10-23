module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3.508000e+01> : tensor<8x7x4xf32>}> : () -> tensor<8x7x4xf32>
    %1 = "tosa.const"() <{values = dense<157> : tensor<10x8x10x6xi16>}> : () -> tensor<10x8x10x6xi16>
    %2 = tosa.sigmoid %0 : (tensor<8x7x4xf32>) -> tensor<8x7x4xf32>
    %3 = tosa.clz %1 : (tensor<10x8x10x6xi16>) -> tensor<10x8x10x6xi16>
    %cast = tensor.cast %2 : tensor<8x7x4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %3 : tensor<10x8x10x6xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

